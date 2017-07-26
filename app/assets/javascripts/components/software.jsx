class Software extends React.Component{
    constructor(props) {
        super(props);

        this.state = {
            versions: [],
            currentVersion: ""
        };

        this.changeHandler = this.changeHandler.bind(this)
    }
    componentWillMount() {
        this.updateVersionsAjax();
    }
    // Request all software related versions
    updateVersionsAjax() {
        let software_id = this.props.software.id;
        let self = this;
        $.ajax({
            method: "GET",
            url: "/softwares/" + software_id + "/versions.json",
            success(versions) {
                self.setState({versions: versions});
                self.setState({currentVersion: self.state.versions[0]});
                //console.log("Ajax success")
            }
        });
    }
    changeHandler(newVal) {
        let versions = this.state.versions;
        let currentVersion = versions.find((version) => {
            return version.id.toString() === newVal;
        });
        this.setState({currentVersion: currentVersion});
    }
    render() {
        //console.log("Render Software");

        // Props
        let software = this.props.software,
            editor = this.props.editor;

        // States
        let links = this.props.links,
            versions = this.state.versions,
            currentVersion = this.state.currentVersion;

        // HTML elements
        let OsIcons = undefined,
            distrilogAvailability = undefined,
            releaseDate = undefined,
            dlButton = undefined,
            docButton = undefined;

        distrilogAvailability = currentVersion.distrilog ? "available" : "<b>not</b> available";
        releaseDate = currentVersion.date ? currentVersion.date : "not specified";

        //console.log(currentVersion);

        return <div className="container-fluid">
            <a className="btn btn-primary" href={links.back}>Back</a>

            <h1>{ software.name }</h1>

            <div className="show-header">
                <div className="software-details">
                    <b>Editor : </b>
                    { editor.name }<br />

                    <b>Short description :</b>
                    { software.short_desc }

                    <br />

                    <div className="btn-group isolated" role="group">
                        <a className="btn btn-default btn-xs" href={links.edit_soft}>Edit</a>
                        <a className="btn btn-danger btn-xs"
                           data-method="delete" data-confirm="You're about to delete this program. Are you sure ?" rel="nofollow"
                           href={links.delete_soft}>Delete</a>
                    </div>
                </div>


                <div className="right-column">
                    <label className="control-label">Version : </label>

                    <VersionSelect
                        id="select-version"
                        className="form-control"
                        versions={versions}
                        currentVersionId={currentVersion.id}
                        onChange={this.changeHandler}
                    />

                    <br />

                    <a className="btn btn-large btn-primary isolated"
                       href={links.new_software_version}>New version
                    </a>
                </div>
            </div>

            <hr />

            <div className="version-header">
                <strong>{ software.name }</strong>
                <div id="version-name" className="col-md-1">{currentVersion.name}</div>

                <div className="btn-group" role="group">
                    <a className="btn btn-default btn-xs"
                       id="edit-version"
                       href={"/versions/" + currentVersion.id + "/edit"}>
                        Edit
                    </a>
                    <a className="btn btn-danger btn-xs"
                       id="destroy-version"
                       data-method="delete" data-confirm="You're about to delete this version. Are you sure ?"
                       href={"/versions/" + currentVersion.id}>
                        Delete
                    </a>
                </div>
            </div>

            <div>
                {/* Nav tabs */}
                <ul className="nav nav-tabs" role="tablist">
                    <li role="presentation"><a href="#details" aria-controls="details" aria-expanded="true" role="tab" data-toggle="tab">Details</a></li>
                    <li role="presentation"><a href="#presentation" aria-controls="presentation" role="tab" data-toggle="tab">Presentation</a></li>
                </ul>

                {/*  Tab panes */}
                <div className="tab-content" id="version-desc">
                    <div role="tabpanel" className="tab-pane fade active" id="details">
                        <div className="version-details bs-callout bs-callout-info">
                            <dl className="dl-horizontal">
                                <dt>OS</dt>
                                <dd>
                                    <i className='fa fa-windows os-icon' aria-hidden='true'></i>
                                    <i className='fa fa-linux os-icon' aria-hidden='true'></i>
                                    <i className='fa fa-apple os-icon' aria-hidden='true'></i>
                                </dd>

                                <dt>Release date</dt>
                                <dd>
                                    <div id="version-date" className="col-md-3">{releaseDate}</div>
                                </dd>

                                <dt>Distrilog</dt>
                                <dd>
                                    <div id="version-distrilog" className="col-md-3" dangerouslySetInnerHTML={{__html: distrilogAvailability}}></div>
                                </dd>
                            </dl>

                            <div className="link-buttons">
                                <a href="#" target="_blank" id="dl-link" className="btn btn-sm btn-primary external-link">Download</a>
                                <a href="#" target="_blank" id="doc-link" className="btn btn-sm btn-primary external-link">Visit website</a>
                            </div>
                        </div>
                    </div>

                    <div role="tabpanel" className="tab-pane fade" id="presentation">
                        <h1>Presentation</h1>
                    </div>
                </div>

            </div>
        </div>;
    }
}

class VersionSelect extends React.PureComponent{
    constructor (props) {
        super(props);

        this.state = {
            value: this.props.currentVersionId
        };

        this.changeHandler = this.changeHandler.bind(this);
    }
    componentDidMount () {
        this.mySelect = $(ReactDOM.findDOMNode(this));
        this.mySelect
            .select2({theme: "bootstrap"})
            .on('change', this.changeHandler);
        //console.log(this.props);
    }
    changeHandler(event) {
        this.setState({value: event.target.value});
        this.props.onChange(this.state.value.toString());
    }
    render () {
        //console.log("Render VersionSelect");

        let versionOptions = this.props.versions.map(
            version => <option key={version.id} value={version.id}>{version.name}</option>
        );

        return <select className="form-control" id="select-version" onChange={this.changeHandler}>
            {versionOptions}
        </select>;
    }
}
